autocmd BufWritePre *.go lua vim.lsp.buf.format(nil, 1000)
