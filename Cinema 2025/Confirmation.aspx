<%@ Page Title="Booking Confirmation" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Cinema_2025.Confirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .confirmation-container {
            max-width: 600px;
            margin: 40px auto;
            background-color: #1a1a1a;
            color: white;
            padding: 30px;
            border-radius: 12px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 4px 15px rgba(255, 0, 0, 0.5);
            text-align: center;
        }
        .confirmation-container h2 {
            color: red;
            margin-bottom: 20px;
        }
        .confirmation-container p {
            font-size: 18px;
            margin: 10px 0;
        }
        .back-home-btn {
            margin-top: 25px;
            background-color: red;
            border: none;
            padding: 10px 20px;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .back-home-btn:hover {
            background-color: darkred;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="confirmation-container">
        <h2>Booking Confirmed!</h2>
        <p><strong>Movie:</strong> <asp:Label ID="MovieLabel" runat="server" /></p>
        <p><strong>Time:</strong> <asp:Label ID="TimeLabel" runat="server" /></p>
        <p><strong>Seats:</strong> <asp:Label ID="SeatsLabel" runat="server" /></p>
        <p><strong>Name:</strong> <asp:Label ID="NameLabel" runat="server" /></p>

        <!-- MessageLabel for showing status messages -->
        <p>
            <asp:Label ID="MessageLabel" runat="server" ForeColor="Yellow" />
        </p>

        <a href="Home.aspx" class="back-home-btn">Back to Home</a>
    </div>
</asp:Content>

