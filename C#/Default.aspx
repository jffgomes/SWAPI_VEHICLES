<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>SWAPI DEMO - Vehicles</title>
        <link rel="stylesheet" href="css/Main.css"/>
</head>
<body>
    <table style="margin-top: 80px">
        <tr>
            <td>
                SWAPI - Demo
            </td>
            <td>
                Recuperando dados da API Pública: <a href="https://swapi.co/api/vehicles/" target="_blank">SWAPI</a>
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
            <div class="navbar">
                <div id="logo">
                    <p class="site-name"> <a class="navbar-brand" href="https://github.com/jffgomes/SWAPI_VEHICLES" target="_blank" title="GitHub" rel="home">GitHub</a></p> 
                </div>
                <a class="navbar-brand" href="https://swapi.co/" target="_blank" title="SWAPI" rel="home">SWAPI</a>  
                <a style="float: right" class="navbar-brand" href="https://br.linkedin.com/in/jhonatan-gomes-50074b190" target="_blank" title="SWAPI" rel="home">LinkedIn</a>  <%--<a href="#news">News</a>--%>
            
            </div>
        <div>

            <div class="main" runat="server">
    <div runat="server" id="dv_GridView" style="max-height:300px; overflow-y:scroll; overflow-x:hidden; margin-top:20px; font-family:Arial,Verdana,Tahoma;">
        <asp:GridView  Visible="true" ID="gv_swapi_vehicles" CssClass="GridGis" Runat="server" DataKeyNames="NAME" AutoGenerateColumns="False" EnableModelValidation="True" HeaderStyle-CssClass="FixedHeader">
        <Columns>
            <asp:BoundField HeaderText="Name" DataField="NAME" SortExpression="NAME"></asp:BoundField>
            <asp:BoundField HeaderText="Model" DataField="MODEL" SortExpression="MODEL"></asp:BoundField>
            <asp:BoundField HeaderText="Price" DataField="cost_in_credits" SortExpression="cost_in_credits"></asp:BoundField>
            <asp:BoundField HeaderText="Length" DataField="length" SortExpression="length"></asp:BoundField>         
            <asp:BoundField HeaderText="Max Speed" DataField="max_atmosphering_speed" SortExpression="max_atmosphering_speed"></asp:BoundField>         
            <asp:BoundField HeaderText="Crew" DataField="crew" SortExpression="crew"></asp:BoundField>         
            <asp:BoundField HeaderText="Passengers" DataField="passengers" SortExpression="passengers"></asp:BoundField>         
            <asp:BoundField HeaderText="Cargo" DataField="cargo_capacity" SortExpression="cargo_capacity"></asp:BoundField>         
            <asp:BoundField HeaderText="Consumables" DataField="consumables" SortExpression="consumables"></asp:BoundField>         
            <asp:BoundField HeaderText="Class" DataField="vehicle_class" SortExpression="vehicle_class"></asp:BoundField>         
            <asp:BoundField HeaderText="url" DataField="url" SortExpression="url"></asp:BoundField>         
        </Columns>
    </asp:GridView>
    </div>
    <asp:Button OnCommand="getVehicles" CssClass="button" Text="Executar" runat="server" />
               <asp:Label runat="server" ID="lb_error" Text=""/>
</div>

        </div>
    </form>
</body>
</html>
