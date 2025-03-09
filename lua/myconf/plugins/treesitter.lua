return {
    "nvim-treesitter/nvim-treesitter",  -- Aggiungi il plugin treesitter
    run = ":TSUpdate",  -- Aggiorna i parser se necessario
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua", "python", "javascript", "markdown" },  -- Aggiungi qui gli altri linguaggi che usi
            highlight = {
                enable = true,  -- Abilita la colorazione della sintassi
                disable = {},  -- Puoi disabilitare linguaggi specifici qui, se necessario
            },
            indent = {
                enable = true,  -- Abilita l'indentazione automatica
            },
        }
    end
}
