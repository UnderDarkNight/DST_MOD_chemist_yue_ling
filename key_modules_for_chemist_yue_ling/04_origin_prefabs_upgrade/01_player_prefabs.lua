




AddPlayerPostInit(function(inst)


    inst:ListenForEvent("rpc_test_data_from_server", function(inst, data)
        print("rpc_test_data_from_server",data)
    end)



    if not TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("rpc_test_data_from_client", function(inst, data)
        print("rpc_test_data_from_client",data)
    end)

end)