<%@ Page Title="Search" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Cinema_2025.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .movie-card {
            background-color: #1a1a1a;
            color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(255, 0, 0, 0.2);
            width: 220px;
            padding: 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .movie-card:hover {
            transform: scale(1.07);
            box-shadow: 0 8px 25px rgba(255, 0, 0, 0.5);
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

        .search-filters {
            padding: 15px;
            text-align: center;
        }

        .status-message {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            margin: 10px;
        }

        .red {
            color: red;
        }

        .grey {
            color: gray;
        }
    </style>
    <link rel="stylesheet" href="home.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="search-filters">
        <asp:DropDownList ID="GenreDropdown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged" AppendDataBoundItems="true" />
    </div>

    <div class="status-message">
        <asp:Label ID="ResultCountLabel" runat="server" CssClass="grey" />
        <asp:Label ID="NoResultsLabel" runat="server" CssClass="red" Visible="false" Text="No movies found." />
    </div>

    <!-- Search Results Heading -->
    <h2 style="color: white; margin: 20px 0; text-align: center;">Search Results</h2>

    <div class="movie-grid">
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal">
            <ItemTemplate>
                <a href='<%# "Details.aspx?id=" + Eval("MovieID") %>'>
                    <div class="movie-card">
                        <asp:Image ID="Poster" runat="server" ImageUrl='<%# Eval("PosterImageURL") %>' Width="100%" Height="200px" Style="object-fit:cover; border-radius:8px;" />
                        <div class="movie-title">
                            <%# Eval("Title") %>
                        </div>
                        <div class="movie-info">
                            <%# Eval("Genre") %> • <%# Eval("Rating") %>
                        </div>
                        <div class="movie-meta">
                            <%# Eval("Format") %> | <%# Eval("Duration") %> min
                        </div>
                    </div>
                </a>
            </ItemTemplate>
        </asp:DataList>
    </div>

</asp:Content>




