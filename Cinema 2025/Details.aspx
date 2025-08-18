<%@ Page Title="Movie Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Cinema_2025.Details" %>  

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">     
    <link rel="stylesheet" href="Details.css" />     
    <style>         
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #000; 
            color: #fff; 
        }         

        .details-container { 
            display: flex; 
            flex-wrap: wrap; 
            max-width: 1200px; 
            margin: 40px auto; 
            gap: 30px; 
        }                  

        /* Poster */         
        .poster-wrapper {              
            flex: 1;              
            min-width: 250px;   
            max-width: 300px;   
            height: 400px;      
            position: relative;              
            cursor: pointer;              
            overflow: hidden;              
            border-radius: 12px;              
        }         
        .poster-wrapper img {              
            width: 100%;              
            height: 100%;              
            object-fit: cover;             
            transition: transform 0.3s;          
        }         
        .poster-wrapper img:hover { transform: scale(1.05); }          

        /* Play button overlay */         
        .play-btn {             
            position: absolute;             
            top: 50%;              
            left: 50%;             
            transform: translate(-50%, -50%);             
            width: 30px;             
            height: 30px;             
            background: rgba(255, 0, 0, 0.8);             
            border-radius: 50%;             
            display: flex;             
            justify-content: center;             
            align-items: center;         
        }         
        .play-btn::after {             
            content: '';             
            border-style: solid;             
            border-width: 8px 0 8px 14px;             
            border-color: transparent transparent transparent #fff;             
            margin-left: 2px;         
        }          

        .details-text { 
            flex: 2; 
            min-width: 400px; 
            display: flex; 
            flex-direction: column; 
            gap: 10px; 
        }         
        h2 { color: red; margin-bottom: 10px; }         
        p { margin: 5px 0; }         
        .booking-section { 
            margin-top: 20px; 
            padding: 20px; 
            background-color: #111; 
            border-radius: 12px; 
        }         
        .dropdown, .seat-list { margin-bottom: 15px; }         
        .book-now-btn { 
            background-color: red; 
            border: none; 
            padding: 10px 20px; 
            border-radius: 6px; 
            color: #fff; 
            cursor: pointer; 
        }         
        .book-now-btn:hover { background-color: darkred; }          

        /* Modal */         
        .modal { 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            position: fixed; 
            z-index: 1000; 
            left: 0; 
            top: 0; 
            width: 100%; 
            height: 100%; 
            background-color: rgba(0,0,0,0.9); 
            opacity: 0; 
            visibility: hidden; 
            transition: opacity 0.4s ease, visibility 0.4s ease; 
        }         
        .modal.show { 
            opacity: 1; 
            visibility: visible; 
        }         
        .modal-content { 
            width: 80%; 
            max-width: 800px; 
            position: relative; 
            transform: translateY(-30px); 
            transition: transform 0.4s ease; 
        }         
        .modal.show .modal-content { 
            transform: translateY(0); 
        }         
        .close { 
            color: #fff; 
            position: absolute; 
            top: -35px; 
            right: 0; 
            font-size: 28px; 
            cursor: pointer; 
        }     
    </style> 
</asp:Content>  

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">     
    <div class="details-container">         
        <!-- Poster Image with Play Button -->         
        <div class="poster-wrapper" onclick="openTrailerModal()">             
            <asp:Image ID="PosterImage" runat="server" CssClass="poster" />             
            <div class="play-btn"></div>         
        </div>  

        <!-- Movie Details Text Box -->         
        <div class="details-text">             
            <h2><asp:Label ID="TitleLabel" runat="server" /></h2>             
            <p><strong>Genre:</strong> <asp:Label ID="GenreLabel" runat="server" /></p>             
            <p><strong>Release Date:</strong> <asp:Label ID="ReleaseDateLabel" runat="server" /></p>             
            <p><strong>Language:</strong> <asp:Label ID="LanguageLabel" runat="server" /></p>             
            <p><strong>Country:</strong> <asp:Label ID="CountryLabel" runat="server" /></p>             
            <p><strong>Rating:</strong> <asp:Label ID="RatingLabel" runat="server" /></p>             
            <p><strong>Duration:</strong> <asp:Label ID="DurationLabel" runat="server" /> min</p>             
            <p><strong>Format:</strong> <asp:Label ID="FormatLabel" runat="server" /></p>             
            <p><strong>Price:</strong> R <asp:Label ID="PriceLabel" runat="server" /></p>             
            <p><strong>Director:</strong> <asp:Label ID="DirectorLabel" runat="server" /></p>             
            <p><strong>Cast:</strong> <asp:Label ID="CastLabel" runat="server" /></p>             
            <p><strong>Description:</strong></p>             
            <p><asp:Label ID="DescriptionLabel" runat="server" /></p>              

            <!-- Booking Section -->             
            <div class="booking-section">                 
                <h3>Book Your Ticket</h3>                 
                <p><strong>Select Time:</strong></p>                 
                <asp:DropDownList ID="TimeDropdown" runat="server" CssClass="dropdown" />                 
                <p><strong>Select Seat(s):</strong></p>                 
                <asp:CheckBoxList ID="SeatCheckboxList" runat="server" RepeatDirection="Horizontal" CssClass="seat-list" />                 
                <asp:Button ID="BookNowButton" runat="server" Text="Book Now" CssClass="book-now-btn" OnClick="BookNowButton_Click" />                 
                <asp:Label ID="BookingStatusLabel" runat="server" CssClass="booking-status" />             
            </div>         
        </div>     
    </div>      

    <!-- Trailer Modal -->     
    <div id="trailerModal" class="modal">         
        <div class="modal-content">  
            <span class="close" onclick="closeTrailerModal()">&times;</span>           
            <asp:Literal ID="TrailerLiteralModal" runat="server" />         
        </div>     
    </div>      

    <script>
        function openTrailerModal() {
            var modal = document.getElementById('trailerModal');
            var container = modal.querySelector(".modal-content");
            var iframe = container.querySelector("iframe");
            var video = container.querySelector("video");

            modal.classList.add("show");

            // Handle iframe autoplay
            if (iframe) {
                let src = iframe.getAttribute("src");
                if (!src.includes("autoplay=1")) {
                    iframe.setAttribute("src", src + (src.includes("?") ? "&" : "?") + "autoplay=1");
                }
            }

            // Handle video autoplay
            if (video) {
                video.play();
            }
        }

        function closeTrailerModal() {
            var modal = document.getElementById('trailerModal');
            var container = modal.querySelector(".modal-content");
            var iframe = container.querySelector("iframe");
            var video = container.querySelector("video");

            modal.classList.remove("show");

            // Stop iframe
            if (iframe) {
                let src = iframe.getAttribute("src").replace("&autoplay=1", "").replace("?autoplay=1", "");
                iframe.setAttribute("src", src);
            }

            // Stop video
            if (video) {
                video.pause();
                video.currentTime = 0;
            }
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
            var modal = document.getElementById('trailerModal');
            if (event.target == modal) {
                closeTrailerModal();
            }
        }
    </script> 
</asp:Content>






