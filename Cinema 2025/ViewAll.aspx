<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ViewAll.aspx.cs" Inherits="Cinema_2025.ViewAll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .movie-grid {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;       /* or space-between / space-evenly */
        gap: 20px;                     /* even space between cards */
        padding: 20px;
        box-sizing: border-box;
    }

    .movie-card {
        background-color: #1a1a1a;
        color: white;
        border: 2px solid transparent;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(255, 0, 0, 0.2);
        width: 220px;
        padding: 15px;
        text-align: center;
        font-family: 'Segoe UI', sans-serif;
        transition: transform 0.3s ease, box-shadow 0.3s ease, border 0.3s ease;
        box-sizing: border-box;
        flex-shrink: 0;                /* Prevents cards from shrinking */
        margin: 20px 0;
    }

    .movie-card:hover {
        transform: scale(1.07);
        box-shadow: 0 8px 25px rgba(255, 0, 0, 0.5);
        border: 2px solid red;
    }

    .movie-card img {
        display: block;
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 10px;
        margin: 0 auto 10px auto;
    }

    .movie-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 6px;
        color: red;
    }

    .movie-info {
        font-size: 14px;
        color: #ddd;
        margin-bottom: 5px;
    }

    .movie-meta {
        font-size: 13px;
        color: #aaa;
    }

    @media (max-width: 768px) {
        .movie-card {
            width: 45%;
        }
    }

    @media (max-width: 480px) {
        .movie-card {
            width: 100%;
        }
    }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width:100%;">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <div class="movie-grid">
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="4" CellPadding="0" CellSpacing="1" RepeatDirection="Horizontal" HorizontalAlign="Center">
        <ItemTemplate>
            <a href='Details.aspx?id=<%# Eval("MovieID") %>' class="movie-link">
            <div class="movie-card">
                <asp:ImageMap 
                    ID="ImageMap2" 
                    runat="server" 
                    AlternateText='<%# Eval("Title") %>' 
                    ImageUrl='<%# Eval("PosterImageURL") %>' 
                    style= height:250px; Width="100%"  />

                <div class="movie-title">
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' />
                </div>

                <div class="movie-info">
                    <asp:Label ID="GenreLabel" runat="server" Text='<%# Eval("Genre") %>' />
                    &nbsp;•&nbsp;
                    <asp:Label ID="RatingLabel" runat="server" Text='<%# Eval("Rating") %>' />
                </div>

                <div class="movie-meta">
                    <asp:Label ID="FormatLabel" runat="server" Text='<%# Eval("Format") %>' />
                    &nbsp;|&nbsp;
                    <asp:Label ID="DurationLabel" runat="server" Text='<%# Eval("Duration") %>' />
                    min
                </div>
            </div>
                </a>
        </ItemTemplate>
    </asp:DataList>
</div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [MovieID], [Title], [Description], [Genre], [PosterImageURL], [Rating], [Country], [Format], [Duration] FROM [Movies]"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
