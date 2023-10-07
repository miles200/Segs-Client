//////////////////////////////////
// JS functions for C++ backend //
//////////////////////////////////

// Application start up functions
function start_up()
{
    set_loader(true);
    get_launcher_settings();
    set_loader(false);
}

// Shows loading spinner
function set_loader(status)
{
    if (status === true)
    {
        loader.visible = true;
        background.enabled = false;
    }
    else if (status === false)
    {
        loader.visible = false;
        background.enabled = true;
    }
}

// Retrieves saved launcher settings
// TODO: Rename to better reflect what this does
function get_launcher_settings()
{
    var launcher_settings_obj = backend_launcher_setup.read_launcher_settings();
    if (launcher_settings_obj["initial_config"] === true)
    {
        mainWindowLoader.active = true;
        textField_screen_x.text = launcher_settings_obj["screenX"];
        textField_screen_y.text = launcher_settings_obj["screenY"];
        checkBox_fullscreen.checked = launcher_settings_obj["fullscreen"];
        fetch_server_list();
    }
    else
    {
        console.log("DEBUG: Initial config not complete... show setup");
        loader.visible = false;
        setupScreenLoader.active = true;
    }
}

function set_launcher_game_settings()
{
    var check_state;
    if (checkBox_fullscreen.checked)
        check_state = 1
    else
        check_state = 0
    var launcher_game_settings_obj = {screenX: textField_screen_x.text, screenY: textField_screen_y.text,
        fullscreen: check_state}
    backend_launcher.set_launcher_game_settings(launcher_game_settings_obj);

}

// Get last used server. If stored server name matches a server name on the server list
// set ComboBox to that entry.
function get_last_used_server()
{
    var server_settings_obj = backend_launcher.get_last_used_server();
    for (var i= 0; i < server_list_model.count; i++)
    {
        if(server_list_model.get(i).server_name === server_settings_obj["server_name"])
        {
            comboBox_server_select.currentIndex = i;
        }
        else
            comboBox_server_select.currentIndex = 0;
    }
    fetch_release_info();
}

// Function called first to allow back end to retrieve JSON from Github.
function fetch_server_list()
{

    backend_launcher.fetchServerListFinished.connect(populate_server_list);
    backend_launcher.fetch_community_servers();
}

// Get list of community and local servers from QSettings - populate ComboBox
function populate_server_list()
{
    var server_obj = backend_launcher.get_server_list();
    var temp;
    var type;
    for (var i = 0, l = Object.keys(server_obj.Servers).length; i < l; i++)
    {
        if (server_obj.Servers[i].server_type === "C")
        {
            temp = server_obj.Servers[i].server_name + " (" +
                    server_obj.Servers[i].server_ip + ") ";
            type = "Community";
        }
        else if (server_obj.Servers[i].server_type === "L")
        {
            temp = server_obj.Servers[i].server_name + " (" +
                    server_obj.Servers[i].server_ip + ") ";
            type = "Custom";
        }
        server_list_model.append({"displayText": temp, "displayTextType": type, "server_type": server_obj.Servers[i].server_type,
                                     "server_name": server_obj.Servers[i].server_name,
                                     "server_ip": server_obj.Servers[i].server_ip, "comboBox_server_select_svg": "Resources/Icons/refresh-cw.svg"});
    }
    backend_launcher.serverStatusReady.connect(get_server_status);
    backend_launcher.start_server_status_worker();
    get_last_used_server();
}

// Gets status of Online server
function get_server_status()
{
    var server_status_obj = backend_launcher.is_server_online();
    for (var i = 0, l = server_list_model.count; i < l; i++)
    {
        if(server_status_obj["server_name"] === server_list_model.get(i).server_name)
        {
            if(server_status_obj["server_status"] === true)
            {
                if(server_list_model.get(i).server_type === "C")
                {
                    server_list_model.set(i, {"server_status": true, "server_uptime": server_status_obj["server_uptime"],
                                              "comboBox_server_select_svg": "Resources/Icons/globe_green.svg"});
                }
                else if(server_list_model.get(i).server_type === "L")
                {
                    server_list_model.set(i, {"server_status": true, "server_uptime": server_status_obj["server_uptime"],
                                              "comboBox_server_select_svg": "Resources/Icons/server_green.svg"});
                }
            }
            else
            {
                if(server_list_model.get(i).server_type === "C")
                {
                    server_list_model.set(i, {"server_status": false, "comboBox_server_select_svg": "Resources/Icons/globe_red.svg"});
                }
                else if(server_list_model.get(i).server_type === "L")
                {
                    server_list_model.set(i, {"server_status": false, "comboBox_server_select_svg": "Resources/Icons/server_red.svg"});
                }
            }
        }
        refresh_status_text();
    }
}

// Add custom server
function add_to_server_list(server_name, server_ip)
{
    // Save to settings
    var server_obj = {server_name: server_name, server_ip: server_ip};
    backend_launcher.add_local_server(server_obj);

    // Add to server select combobox
    var temp = server_name + " (" +
            server_ip + ") ";
    server_list_model.append({"displayText": temp, "displayTextType": "Custom", "server_type": "L",
                                 "server_name": server_name,
                                 "server_ip": server_ip, "comboBox_server_select_svg": "Resources/Icons/refresh-cw.svg"});
    var count = server_list_model.count;
    comboBox_server_select.currentIndex = count - 1;
    backend_launcher.start_server_status_worker();

}

// On selection, saves selected server to launcher settings
function set_server()
{
    var server_settings_array = {server_name: server_list_model.get(comboBox_server_select.currentIndex).server_name,
        server_ip: server_list_model.get(comboBox_server_select.currentIndex).server_ip};
    backend_launcher.set_server(server_settings_array);
}

// Refresh server uptime / status text
function refresh_status_text()
{
    if (server_list_model.get(comboBox_server_select.currentIndex).server_status !== undefined)
    {
        if (server_list_model.get(comboBox_server_select.currentIndex).server_status === true)
        {
            label_online.text = "Online for " + server_list_model.get(comboBox_server_select.currentIndex).server_uptime + " days";
            label_online.color = onlineColor;
        }
        else
        {
            label_online.text = "Offline / Unknown Status";
            label_online.color = offlineColor;
        }
    }
    comboBox_server_select_content_img.source = server_list_model.get(comboBox_server_select.currentIndex).comboBox_server_select_svg;

}
// Launches SEGSAdmin
function launch_segsadmin()
{
    backend_launcher.launch_segsadmin();
}

// Function called first to allow back end to retrieve JSON from Github.
function fetch_release_info()
{
    backend_launcher.fetchReleasesFinished.connect(get_release_info);
    backend_launcher.fetch_release_notes();

}

// Get JSON object once fetch_release_info() finished.
function get_release_info()
{
    var release_obj = backend_launcher.get_version_info();
    textArea_release_notes.text = release_obj.release_notes;
    label_version_info.text = release_obj.version_string;
}

// Get server information from settings (Community only)
function get_server_information(server)
{
    var server_info_obj = backend_launcher.get_server_information();
    for (var i = 0, l = Object.keys(server_info_obj.Servers).length; i < l; i++)
    {
        if(server === server_info_obj.Servers[i].server_name)
        {
            server_info_text = "<b>" + server_info_obj.Servers[i].server_description + "</b>"
                    + "<br><b>Register an account at: </b>" + "<a href=" +
                    server_info_obj.Servers[i].server_web_url + ">" +
                    server_info_obj.Servers[i].server_web_url + "</a>";
            return;
        }
        else
        {
            server_info_text = "No server information available";
        }
    }
}
