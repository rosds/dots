-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/alfonso.ros/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/alfonso.ros/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/alfonso.ros/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/alfonso.ros/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/alfonso.ros/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["apex.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/apex.nvim",
    url = "/home/alfonso.ros/apex/apex.nvim"
  },
  ["apexcolors.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/apexcolors.nvim",
    url = "/home/alfonso.ros/apex/apexcolors.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  firenvim = {
    loaded = true,
    needs_bufread = false,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["gitlab.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vgitlab\frequire\0" },
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/gitlab.nvim",
    url = "/home/alfonso.ros/apex/gitlab.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["hotpot.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/hotpot.nvim",
    url = "https://github.com/rktjmp/hotpot.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\rgenerate\vneogen\frequire•\1\1\0\b\0\n\1\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0'\6\b\0003\a\t\0B\3\4\0?\3\0\0B\0\2\1K\0\1\0\0\15<leader>hh\6n\bset\vkeymap\bvim\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\3€€À™\4\0" },
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nightfox.nvim",
    url = "https://github.com/EdenEast/nightfox.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  orgmode = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/orgmode",
    url = "https://github.com/nvim-orgmode/orgmode"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    needs_bufread = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["venn.nvim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-bazel"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-bazel",
    url = "https://github.com/bazelbuild/vim-bazel"
  },
  ["vim-dispatch"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-ingo-library"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-ingo-library",
    url = "https://github.com/inkarkat/vim-ingo-library"
  },
  ["vim-maktaba"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-maktaba",
    url = "https://github.com/google/vim-maktaba"
  },
  ["vim-mark"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/vim-mark",
    url = "https://github.com/inkarkat/vim-mark"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-sandwich"] = {
    loaded = true,
    needs_bufread = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/vim-sandwich",
    url = "https://github.com/machakann/vim-sandwich"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-table-mode",
    url = "https://github.com/dhruvasagar/vim-table-mode"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["zig.vim"] = {
    loaded = true,
    path = "/home/alfonso.ros/.local/share/nvim/site/pack/packer/start/zig.vim",
    url = "https://github.com/ziglang/zig.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: firenvim
time([[Setup for firenvim]], true)
try_loadstring("\27LJ\2\n“\2\0\0\4\0\f\0\r6\0\0\0009\0\1\0005\1\4\0005\2\3\0=\2\5\0015\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\2=\2\v\1=\1\2\0K\0\1\0\18localSettings\a.*\1\0\2\rtakeover\nnever\rpriority\3\0\31https?://gitlab\\.apex\\.ai/\1\0\0\1\0\4\rpriority\3\1\rselector#textarea[class~=markdown-area]\rtakeover\rnonempty\fcontent\rmarkdown\19globalSettings\1\0\0\1\0\1\balt\ball\20firenvim_config\6g\bvim\0", "setup", "firenvim")
time([[Setup for firenvim]], false)
time([[packadd for firenvim]], true)
vim.cmd [[packadd firenvim]]
time([[packadd for firenvim]], false)
-- Setup for: vim-dispatch
time([[Setup for vim-dispatch]], true)
try_loadstring("\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21dispatch_no_maps\6g\bvim\0", "setup", "vim-dispatch")
time([[Setup for vim-dispatch]], false)
time([[packadd for vim-dispatch]], true)
vim.cmd [[packadd vim-dispatch]]
time([[packadd for vim-dispatch]], false)
-- Setup for: rust.vim
time([[Setup for rust.vim]], true)
try_loadstring("\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\21rustfmt_autosave\6g\bvim\0", "setup", "rust.vim")
time([[Setup for rust.vim]], false)
time([[packadd for rust.vim]], true)
vim.cmd [[packadd rust.vim]]
time([[packadd for rust.vim]], false)
-- Setup for: vim-sandwich
time([[Setup for vim-sandwich]], true)
try_loadstring("\27LJ\2\n|\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0K\0\1\0.operator_sandwich_no_default_key_mappings%sandwich_no_default_key_mappings\6g\bvim\0", "setup", "vim-sandwich")
time([[Setup for vim-sandwich]], false)
time([[packadd for vim-sandwich]], true)
vim.cmd [[packadd vim-sandwich]]
time([[packadd for vim-sandwich]], false)
-- Setup for: copilot.vim
time([[Setup for copilot.vim]], true)
try_loadstring("\27LJ\2\n€\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\5\25copilot_tab_fallback\26copilot_assume_mapped\23copilot_no_tab_map\6g\bvim\0", "setup", "copilot.vim")
time([[Setup for copilot.vim]], false)
time([[packadd for copilot.vim]], true)
vim.cmd [[packadd copilot.vim]]
time([[packadd for copilot.vim]], false)
-- Setup for: vim-mark
time([[Setup for vim-mark]], true)
try_loadstring("\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\19mw_no_mappings\6g\bvim\0", "setup", "vim-mark")
time([[Setup for vim-mark]], false)
time([[packadd for vim-mark]], true)
vim.cmd [[packadd vim-mark]]
time([[packadd for vim-mark]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\nD\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0'tmux_navigator_disable_when_zoomed\6g\bvim\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
time([[packadd for vim-tmux-navigator]], true)
vim.cmd [[packadd vim-tmux-navigator]]
time([[packadd for vim-tmux-navigator]], false)
-- Config for: gitlab.nvim
time([[Config for gitlab.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vgitlab\frequire\0", "config", "gitlab.nvim")
time([[Config for gitlab.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\rgenerate\vneogen\frequire•\1\1\0\b\0\n\1\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0006\3\4\0009\3\5\0039\3\6\3'\5\a\0'\6\b\0003\a\t\0B\3\4\0?\3\0\0B\0\2\1K\0\1\0\0\15<leader>hh\6n\bset\vkeymap\bvim\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\3€€À™\4\0", "config", "neogen")
time([[Config for neogen]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
