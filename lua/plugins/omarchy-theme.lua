return {
	{
		name = "omarchy-theme",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 1000,
		config = function()
			local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"
			local omarchy_neovim_config = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")

			local function apply_theme(is_reload)
				-- 1. Load the Omarchy-generated spec
				local theme_spec_func = loadfile(omarchy_neovim_config)
				if not theme_spec_func then
					-- Fallback to default if Omarchy config missing
					pcall(vim.cmd.colorscheme, "tokyonight-night")
					return
				end

				local theme_spec = theme_spec_func()
				if not theme_spec or type(theme_spec) ~= "table" then
					return
				end

				-- 2. Clean up if reloading
				if is_reload then
					-- Clear all highlight groups
					vim.cmd("highlight clear")
					if vim.fn.exists("syntax_on") ~= 0 then
						vim.cmd("syntax reset")
					end
					-- Reset background
					vim.o.background = "dark"

					-- Unload any previous theme plugin modules if possible
					-- (This mimics the robust reloading in omarch_nvim)
					for _, spec in ipairs(theme_spec) do
						local plugin_name = spec.name or spec[1]
						if plugin_name and plugin_name ~= "LazyVim/LazyVim" then
							local plugin = require("lazy.core.config").plugins[plugin_name]
							if plugin and plugin.dir then
								local plugin_dir = plugin.dir .. "/lua"
								require("lazy.core.util").walkmods(plugin_dir, function(modname)
									package.loaded[modname] = nil
									package.preload[modname] = nil
								end)
							end
						end
					end
				end

				-- 3. Find and apply the colorscheme
				for _, spec in ipairs(theme_spec) do
					-- Handle LazyVim-style spec (which Omarchy uses)
					if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
						local colorscheme = spec.opts.colorscheme

						if type(colorscheme) == "function" then
							-- Custom in-line theme (like aetheria)
							colorscheme()
						else
							-- Standard plugin-based theme
							require("lazy.core.loader").colorscheme(colorscheme)
							pcall(vim.cmd.colorscheme, colorscheme)
						end

						-- 4. Re-apply transparency
						if vim.fn.filereadable(transparency_file) == 1 then
							vim.defer_fn(function()
								vim.cmd.source(transparency_file)

								-- Trigger UI updates for various plugins
								vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
								vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })

								if is_reload then
									vim.cmd("redraw!")
								end
							end, 5)
						end

						break
					end
				end
			end

			-- Initial apply
			apply_theme(false)

			-- Listen for Omarchy's reload event
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyReload",
				callback = function()
					vim.schedule(function()
						apply_theme(true)
					end)
				end,
			})
		end,
	},
}
