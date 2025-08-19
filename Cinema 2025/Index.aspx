<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Cinema_2025.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
    <link rel="stylesheet" href="home.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-color: #000000; padding: 20px 0;">
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <asp:Repeater ID="BannerRepeater" runat="server">
                    <ItemTemplate>
                        <div class="swiper-slide">
                            <img src='<%# Eval("ImageUrl") %>' alt="Movie Banner" class="banner-image" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Optional Controls -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
        </div>
                        <div class="movie-grid">
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="4" CellPadding="0" RepeatDirection="Horizontal" HorizontalAlign="Center">
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
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT TOP 8 * FROM [movies] ORDER BY Title"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [MovieID], [Title], [Description], [Genre], [PosterImageURL], [Rating], [Country], [Format], [Duration] FROM [Movies]"></asp:SqlDataSource>
    </div>

    <!-- Swiper JS and Init -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        var swiper = new Swiper(".mySwiper", {
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });
    </script>
</asp:Content>

