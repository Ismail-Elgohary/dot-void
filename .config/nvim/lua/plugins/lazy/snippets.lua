return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            local ls_ok, ls = pcall(require, "luasnip")
            if not ls_ok then return end

            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node

            ls.filetype_extend("javascript", { "jsdoc" })

            local next_snippet = {
                s("exp", {
                    t("export default function "), i(1, "ComponentName"), t("("), i(2, "props"), t(") {"),
                    t({"", "  return ("}),
                    t({"", "    <div>"}), i(0), t({"", "    </div>"}),
                    t({"", "  )"}),
                    t({"", "}"}),
                }),
            }

            ls.add_snippets("javascript", next_snippet)
            ls.add_snippets("typescript", next_snippet)

            vim.keymap.set({"i", "s"}, "<Tab>", function()
                if ls.expand_or_jumpable() then
                    return ls.expand_or_jump()
                else
                    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
                end
            end, {expr = true, silent = true})

            vim.keymap.set({"i", "s"}, "<S-Tab>", function()
                if ls.jumpable(-1) then
                    return ls.jump(-1)
                else
                    return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
                end
            end, {expr = true, silent = true})
        end,
    }
}
