<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Cinema_2025.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Sign Up - CINELUX</title>
    <style>
        /* Center the form in the ContentPlaceHolder */
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 70vh; /* avoids overflowing master page */
            padding: 20px 0; 
            background-color: #000;
            box-sizing: border-box;
        }

        /* Form card */
        .login-box {
            background-color: #111;
            border: 1px solid #444;
            padding: 30px 20px;
            width: 100%;
            max-width: 400px;
            border-radius: 10px;
            color: #fff;
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
        }

        /* Heading */
        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ff4d4d;
            font-size: 24px;
        }

        /* Labels */
        .input-label {
            margin-top: 10px;
            margin-bottom: 5px;
            font-weight: bold;
        }

        /* Inputs */
        .login-input {
            width: 95%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #555;
            background-color: #222;
            color: #fff;
            margin-bottom: 15px;
            font-size: 14px;
            position:center;
        }

        .login-input:focus {
            outline: none;
            border-color: red;
            box-shadow: 0 0 5px red;
        }

        /* Buttons */
        .login-button {
            background-color: red;
            color: white;
            padding: 12px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: darkred;
        }

        /* Error label */
        .error-label {
            margin-top: 10px;
            text-align: center;
            font-size: 14px;
            color: #ff6666;
        }

        /* Already have account link */
        .login-box .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .login-box .login-link a {
            color: red;
            font-weight: bold;
            text-decoration: none;
        }

        .login-box .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="login-box">
            <h2>Create Account</h2>

            <!-- Name -->
            <label class="input-label" for="NameTxt">Name</label>
            <asp:TextBox ID="NameTxt" runat="server" CssClass="login-input" Placeholder="Enter Name"></asp:TextBox>

            <!-- Surname -->
            <label class="input-label" for="SurnameTxt">Surname</label>
            <asp:TextBox ID="SurnameTxt" runat="server" CssClass="login-input" Placeholder="Enter Surname"></asp:TextBox>

            <!-- Username -->
            <label class="input-label" for="UsernameTxt">Username</label>
            <asp:TextBox ID="UsernameTxt" runat="server" CssClass="login-input" Placeholder="Enter Username"></asp:TextBox>

            <!-- Email -->
            <label class="input-label" for="EmailTxt">Email</label>
            <asp:TextBox ID="EmailTxt" runat="server" CssClass="login-input" Placeholder="Enter Email"></asp:TextBox>

            <!-- Password -->
            <label class="input-label" for="PasswordTxt">Password</label>
            <asp:TextBox ID="PasswordTxt" runat="server" TextMode="Password" CssClass="login-input" Placeholder="Enter Password"></asp:TextBox>

            <!-- Confirm Password -->
            <label class="input-label" for="ConfirmPasswordTxt">Confirm Password</label>
            <asp:TextBox ID="ConfirmPasswordTxt" runat="server" TextMode="Password" CssClass="login-input" Placeholder="Confirm Password"></asp:TextBox>

            <!-- Sign Up Button -->
            <asp:Button ID="SignUpBtn" runat="server" Text="Sign Up" CssClass="login-button" OnClick="SignUpBtn_Click"  />

            <!-- Error Label -->
            <asp:Label ID="ErrorLabel" runat="server" CssClass="error-label" ForeColor="Red"></asp:Label>

            <!-- Already have account -->
            <div class="login-link">
                <span>Already Have an account? </span>
                <a href="Login.aspx">Login</a>
            </div>
        </div>
    </div>
</asp:Content>

