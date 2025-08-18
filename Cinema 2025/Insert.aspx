<%@ Page Title="Insert Movie" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Insert.aspx.cs" Inherits="Cinema_2025.Insert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .insert-container {
            margin-top: 40px; /* space from top */
        }
        table {
            border-collapse: separate;
            border-spacing: 0 10px; /* adds vertical spacing between rows */
        }
        td {
            padding: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="insert-container">
        <h2>Add New Movie</h2>

        <asp:Label ID="MessageLabel" runat="server" ForeColor="Red"></asp:Label>
        <br /><br />

        <table>
            <tr><td>Title:</td><td><asp:TextBox ID="TitleTextBox" runat="server" /></td></tr>
            <tr><td>Description:</td><td><asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Rows="4" Columns="40" /></td></tr>
            <tr><td>Genre:</td><td><asp:TextBox ID="GenreTextBox" runat="server" /></td></tr>
            <tr><td>Release Date:</td><td><asp:TextBox ID="ReleaseDateTextBox" runat="server" TextMode="Date" /></td></tr>
            <tr><td>Duration (mins):</td><td><asp:TextBox ID="DurationTextBox" runat="server" /></td></tr>
            <tr><td>Language:</td><td><asp:TextBox ID="LanguageTextBox" runat="server" /></td></tr>
            <tr><td>Country:</td><td><asp:TextBox ID="CountryTextBox" runat="server" /></td></tr>
            <tr><td>Rating:</td><td><asp:TextBox ID="RatingTextBox" runat="server" /></td></tr>
            <tr><td>Director Name:</td><td><asp:TextBox ID="DirectorNameTextBox" runat="server" /></td></tr>
            <tr><td>Cast Names:</td><td><asp:TextBox ID="CastNamesTextBox" runat="server" /></td></tr>
            <tr><td>Format:</td><td><asp:TextBox ID="FormatTextBox" runat="server" /></td></tr>
            <tr><td>Price:</td><td><asp:TextBox ID="PriceTextBox" runat="server" /></td></tr>
            <tr><td>Movie Code:</td><td><asp:TextBox ID="NextMovieCodeTextBox" runat="server" /></td></tr>
            <tr><td>Movie ID:</td><td><asp:TextBox ID="NextMovieIDTextBox" runat="server" /></td></tr>
            <tr><td>Poster Image Upload:</td><td><asp:FileUpload ID="PosterUpload" runat="server" /></td></tr>
            <tr><td>Trailer Upload (MP4):</td><td><asp:FileUpload ID="TrailerUpload" runat="server" /></td></tr>
            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
        </table>

        <br />
        <asp:Button ID="InsertButton" runat="server" Text="Insert Movie" CssClass="btn btn-primary" OnClick="InsertButton_Click" />
    </div>
    <div>

    </div>
     <div>

     </div>
</asp:Content>

