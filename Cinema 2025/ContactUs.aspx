<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Cinema_2025.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="SignIn.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="login-box">
            <h2>Contact Us</h2>

            <asp:Label ID="NameLabel" runat="server" Text="Your Name:" CssClass="input-label" />
            <asp:TextBox ID="NameTextBox" runat="server" CssClass="login-input" />

            <asp:Label ID="EmailLabel" runat="server" Text="Your Email:" CssClass="input-label" />
            <asp:TextBox ID="EmailTextBox" runat="server" CssClass="login-input" TextMode="Email" />

            <asp:Label ID="MessageLabel" runat="server" Text="Your Message:" CssClass="input-label" />
            <asp:TextBox ID="MessageTextBox" runat="server" CssClass="login-input" TextMode="MultiLine" Rows="5" />

            <asp:Button ID="SendButton" runat="server" Text="Send Message" CssClass="login-button" OnClick="SendButton_Click" />

            <asp:Label ID="StatusLabel" runat="server" CssClass="error-label" />
        </div>
    </div>
</asp:Content>


