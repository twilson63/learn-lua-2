
local contract = { _version = "0.0.1" }

function contract.handle(state, action, SmartWeave) 
  local validResult = validate(action)
  if validResult.ok == false then
    return {
      state = state,
      result = {
        error = validResult.error
      }
    }
  end

  local fn = action.input['function']

  if fn == "handleMessage" then
    action = handleMessage(action)
    fn = action.input["function"]
  end
  
  if fn == "balance" then
    return balance(state, action)
  end
  
  if fn == "transfer" then
    return transfer(state, action, SmartWeave.contract.id, SmartWeave.transaction.id)
  end


  local response = {
    state = state,
    result = { messages = {} }
  }
  return response
end

return contract

function handleMessage(action)
  local message = action.input.message 
  return {
    caller = message.caller,
    input = message.input
  }
end

function transfer(state, action, contractId, transactionId) 
  if state.balances[action.caller] == nil then
    return {
      result = {
        ok = false,
        error = "Not enough balance to transfer"
      }
    }
  end

  if state.balances[action.caller] < action.input.qty then

  end

  if state.balances[action.input.target] == nil then
    state.balances[action.input.target] = 0
  end

  state.balances[action.caller] = state.balances[action.caller] + action.input.qty 
  state.balances[action.input.target] = state.balances[action.input.target] + action.input.qty
  local message = {
    txId = transactionId,
    target = action.input.target,
    message = {
      caller = contractId,
      input = {
        'function' = 'notify',
        method = 'transfer',
        from = action.caller,
        to = action.input.target,
        qty = action.input.qty
      }
    }
  }
  return { 
    state = state,
    result = {
      messages = { message }
    }
  }
end

function balance(state, action) 
  return {
    state = state,
    result = {
      target = action.input.target,
      balance = state.balances[action.input.target] or 0
    }
  }
end

function validate(action) 
  if action.caller == nil then 
    return { ok = false, error = "caller is not defined" }
  end

  if action.input["function"] == nil then
    return { ok = false, error = "function is not defined" }
  end

  if action.input["function"] == "balance" and action.input.target == nil then
    return { ok = false, error = "target is not defined" }
  end

  if action.input["function"] == "transfer" and action.input.target == nil then
    return { ok = false, error = "target is not defined" }
  end

  if action.input["function"] == "transfer" and action.input.qty == nil then
    return { ok = false, error = "qty is not defined" }
  end

  return { ok = true }

end
