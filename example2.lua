local contract = { _version = "0.0.1" }

function contract.handle(state, action, SmartWeave)
    if action.input['function'] == "handleMessage" then
        -- Do something specific for 'handleMessage'
        -- For example, maybe you want to modify the state or return a specific message

        -- Sample code (you should replace this with your desired functionality):
        if not state.count then
            state.count = 0
        end

        state.count = state.count + 1

        local message = {
            txId = SmartWeave.transaction.id,
            target = action.input['message'].caller,
            message = {
                type = "recieved",
                caller = SmartWeave.contract.id,
            }
        }

        local response = {
            state = state,
            result = { messages = {message} }
        }

        return response
    else
        local message = {}

        local response = {
            state = state,
            result = { messages = {message} }
        }

        return response
    end
end

return contract