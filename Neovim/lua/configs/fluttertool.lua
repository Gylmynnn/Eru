require("flutter-tools").setup {
    decorations = {
        statusline = {
            app_version = true,
            device = true,
        },
    },
    widget_guides = {
        enabled = false,
    },
    closing_tags = {
        highlight = "Comment",
        prefix = "</女>",
        enabled = true,
    },
    lsp = {
        color = {
            enabled = true,
            background = true,
            foreground = false,
            virtual_text = true,
            virtual_text_str = "■",
        },
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            enableSnippets = true,
        },
    },
}
