require("tiny-inline-diagnostic").setup {
    preset = "ghost",
    hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "None",
    },
    options = {
        show_source = false,
        use_icons_from_diagnostic = false,
        add_messages = true,
        throttle = 20,
        softwrap = 30,
        multiple_diag_under_cursor = false,
        multilines = false,
        show_all_diags_on_cursorline = false,
        enable_on_insert = false,
        overflow = {
            mode = "wrap",
        },
        format = nil,

        break_line = {
            enabled = false,
            after = 30,
        },

        virt_texts = {
            false,
            priority = 2048,
        },

        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        overwrite_events = nil,
    },
}
