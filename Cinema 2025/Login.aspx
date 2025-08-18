<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Cinema_2025.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="SignIn.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="login-box">
            <h2>Login</h2>

            <asp:Label ID="UsernameLabel" runat="server" Text="Username:" CssClass="input-label" />
            <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="login-input" />

            <asp:Label ID="PasswordLabel" runat="server" Text="Password:" CssClass="input-label" />
            <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="login-input" />

            <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="login-button" OnClick="LoginButton_Click" />

            <asp:Label ID="ErrorMessage" runat="server" CssClass="error-label" ForeColor="Red" />
        </div>
        <div>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Visible="False">
                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                    <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [EmployeeLogins]"></asp:SqlDataSource>

        </div>
    </div>
</asp:Content>

