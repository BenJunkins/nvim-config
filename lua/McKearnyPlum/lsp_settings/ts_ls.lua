-- Disable formatting so it doesn't fight with Prettier

return {
    on_attach = function (client)
        client.server_capabilities.documentFormattingProvider = false
    end
}
