local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
local resourceName = "ars-job-outfit"



CreateThread(function()
    if GetCurrentResourceName() ~= resourceName then
        resourceName = "ars-job-outfit (" .. GetCurrentResourceName() .. ")"
    end
end)

CreateThread(function()
    while true do
        PerformHttpRequest("https://api.github.com/repos/Arius-Development/"..resourceName.."/releases/latest", versionCheck, "GET")
        Wait(3600000)
    end
end)

function versionCheck(err, responseText, headers)
    local latestVersion, URL, body = getLatestInformations()
    CreateThread(function()
        if currentVersion ~= latestVersion then
            Wait(1000)
            print("^0[^6ALERT^0] ^1AN UPDATE IS AVAILABLE")
            print("^0[^6ALERT^0] Your Version: ^6" .. currentVersion .. "^0")
            print("^0[^6ALERT^0] Latest Version: ^6" .. latestVersion .. "^0")
            print("^0[^6ALERT^0] Get the latest Version from: ^3" .. URL .. "^0")
        else
            Wait(4000)
            print("^0[^6INFO^0] " .. resourceName .. " is up to date! (^6" .. currentVersion .. "^0)")
        end
    end)
end

function getLatestInformations()
    local latestVersion, URL, body = nil, nil, nil
    PerformHttpRequest("https://api.github.com/repos/Arius-Development/"..resourceName.."/releases/latest", function(err, response, headers)
        if err == 200 then
            local data = json.decode(response)
            latestVersion = data.tag_name
            URL = data.html_url
            body = data.body
        else
            latestVersion = currentVersion
            URL = "https://github.com/Arius-Development/"..resourceName
        end
    end, "GET")
    repeat
        Wait(50)
    until (latestVersion and URL and body)
    return latestVersion, URL, body
end
