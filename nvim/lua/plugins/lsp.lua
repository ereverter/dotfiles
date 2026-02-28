return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "gopls",
        "goimports",
        "golangci-lint",
        "ruff",
        "basedpyright",
        "typescript-language-server",
        "eslint-lsp",
        "prettierd",
        "yaml-language-server",
        "json-lsp",
        "dockerfile-language-server",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
        python = { "ruff_format", "ruff_organize_imports" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
        sh = { "shellcheck" },
      },
    },
  },
}
