<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Cinema_2025.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Checkout.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-container">
        <h2>Checkout</h2>
        <p><strong>Movie:</strong> <asp:Label ID="MovieTitleLabel" runat="server" /></p>
        <p><strong>Time:</strong> <asp:Label ID="TimeLabel" runat="server" /></p>
        <p><strong>Seats:</strong> <asp:Label ID="SeatsLabel" runat="server" /></p>

        <hr />
        <h3>Enter Your Details</h3>

        <asp:Label ID="ErrorLabel" runat="server" ForeColor="Red" />

        <p>Name: <asp:TextBox ID="NameTextBox" runat="server" /></p>
        <p>Email: <asp:TextBox ID="EmailTextBox" runat="server" TextMode="Email" /></p>
        <p>Phone: <asp:TextBox ID="PhoneTextBox" runat="server" /></p>

        <asp:Button ID="ConfirmBookingButton" runat="server" Text="Confirm Booking" OnClick="ConfirmBookingButton_Click" CssClass="confirm-btn" />
    </div>
</asp:Content>
