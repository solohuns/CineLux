<%@ Page Title="Update Movie" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Update.aspx.cs" Inherits="Cinema_2025.Update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .form-label {
            font-weight: bold;
            padding: 5px;
        }

        .form-row {
            padding: 8px 0;
        }

        .form-title {
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            padding: 10px 0;
        }

        .form-table {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="form-table">
        <tr>
            <td colspan="2" class="form-title">Update Movie</td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Enter Movie code to Load:</td>
            <td>
                <asp:TextBox ID="MovieCodetxt" runat="server" Width="150px" />
                <asp:Button ID="LoadMovieBtn" runat="server" Text="Load Movie" CssClass="btn btn-info" OnClick="LoadMovieBtn_Click" />
            </td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Movie ID</td>
            <td><asp:TextBox ID="MovieIDUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Title</td>
            <td><asp:TextBox ID="TitleUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Description</td>
            <td><asp:TextBox ID="DesricptionUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Genre</td>
            <td><asp:TextBox ID="GenreUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Release Date</td>
            <td><asp:TextBox ID="ReleaseDateUpdatetxt" runat="server" Width="200px" TextMode="Date" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Duration (min)</td>
            <td><asp:TextBox ID="DurationUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Language</td>
            <td><asp:TextBox ID="LanguageUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Country</td>
            <td><asp:TextBox ID="CountryUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Rating</td>
            <td><asp:TextBox ID="RatingUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Poster Image URL</td>
            <td><asp:TextBox ID="PosterImageURLupdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Trailer URL</td>
            <td><asp:TextBox ID="TrailerURLupdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Cast Names</td>
            <td><asp:TextBox ID="CastNamesUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Director Name</td>
            <td><asp:TextBox ID="DirectorNameUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Format</td>
            <td><asp:TextBox ID="FormatUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td class="form-label">Price</td>
            <td><asp:TextBox ID="PriceUpdatetxt" runat="server" Width="200px" /></td>
        </tr>

        <tr class="form-row">
            <td></td>
            <td>
                <asp:Button ID="UpdateBtn" runat="server" Text="Update Movie" CssClass="btn btn-primary" OnClick="UpdateBtn_Click" />
            </td>
        </tr>

        <tr class="form-row">
            <td>&nbsp;</td>
            <td>
                <asp:Label ID="StatusLabel" runat="server" ForeColor="Green" Font-Bold="true" />
            </td>
        </tr>
    </table>
</asp:Content>

