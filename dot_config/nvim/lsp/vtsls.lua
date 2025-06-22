-- Install with: npm i -g @vtsls/language-server

local jsts_settings = {
	suggest = { completeFunctionCalls = true },
	inlayHints = {
		functionLikeReturnTypes = { enabled = true },
		parameterNames = { enabled = "literals" },
		variableTypes = { enabled = true },
	},
}

---@type vim.lsp.Config
return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_dir = function(bufnr, cb)
		local fname = vim.uri_to_fname(vim.uri_from_bufnr(bufnr))

		local ts_root = vim.fs.find("tsconfig.json", { upward = true, path = fname })[1]
		-- Use the git root to deal with monorepos where TypeScript is installed in the root node_modules folder.
		local git_root = vim.fs.find(".git", { upward = true, path = fname })[1]

		if git_root then
			cb(vim.fn.fnamemodify(git_root, ":h"))
		elseif ts_root then
			cb(vim.fn.fnamemodify(ts_root, ":h"))
		end
	end,
	settings = {
		typescript = jsts_settings,
		javascript = jsts_settings,
		vtsls = {
			-- typescript = {
			-- 	globalTsdk = get_global_tsdk(),
			-- },
			-- Automatically use workspace version of TypeScript lib on startup.
			autoUseWorkspaceTsdk = true,
			experimental = {
				-- Inlay hint truncation.
				maxInlayHintLength = 30,
				-- For completion performance.
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
	},
}
