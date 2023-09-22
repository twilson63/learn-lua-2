local contract = { _version = "0.0.1" }

function contract.handle(state, action, SmartWeave)
    print("beginning")

    if action.input['function'] == "handleMessage" then
        -- Do something specific for 'handleMessage'
        -- For example, maybe you want to modify the state or return a specific message

        -- Sample code (you should replace this with your desired functionality):
        local response = {
            state = state,
            result = { messages = {} }
        }
        return response
    else
        -- Existing code
        if not state.count then
            state.count = 0
        end

        state.count = state.count + 1

        local message = {
            txId = SmartWeave.transaction.id,
            target = state.sendToContract,
            message = {
                type = "transfer",
                caller = SmartWeave.contract.id,
                qty = 10,
                from = SmartWeave.contract.id,
                to = state.sendToContract
            }
        }

        local response = {
            state = state,
            result = { messages = {message} }
        }

        print("returning")

        return response
    end
end