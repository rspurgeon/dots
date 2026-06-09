local long_line_limit = 20000

for lnum = 1, vim.api.nvim_buf_line_count(0) do
    local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""
    if #line > long_line_limit then
        -- YAML regex syntax can exhaust maxmempattern on large base64/data lines.
        vim.cmd("syntax clear")
        vim.bo.syntax = "OFF"
        vim.b.yaml_regex_syntax_disabled_for_long_line = true
        break
    end
end
