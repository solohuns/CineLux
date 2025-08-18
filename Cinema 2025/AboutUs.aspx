<%@ Page Title="About Us - CineLux" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Cinema_2025.AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .about-us-container {
            background-color: #111111;
            color: #f0f0f0;
            padding: 30px;
            border-radius: 12px;
            max-width: 800px;
            margin: 40px auto;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .about-us-container h2 {
            color: #e50914;
            text-align: center;
            margin-bottom: 20px;
        }

        .about-us-container ul {
            padding-left: 20px;
            list-style-type: disc;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="about-us-container">
        <h2>About Us – CineLux</h2>
        <p>
            Welcome to <strong>CineLux</strong> – your ultimate destination for cinematic excellence.
        </p>
        <p>
            At CineLux, we’re more than just a movie theater — we’re a place where stories come to life.
            From the latest blockbusters to timeless classics, we bring the magic of film to our audiences
            in a setting designed for comfort, quality, and unforgettable experiences.
        </p>
        <p>
            Our cinemas are equipped with <strong>state-of-the-art projection and sound technology</strong>,
            <strong>luxurious seating</strong>, and <strong>personalized service</strong> that make every visit feel special.
            Whether you're here for a family outing, date night, or solo movie escape, we’ve crafted an atmosphere
            where every guest can relax and immerse themselves in the world of film.
        </p>
        <ul>
            <li>Crystal-clear 4K digital projection & Dolby surround sound</li>
            <li>Comfortable, modern seating with spacious legroom</li>
            <li>Online booking, reserved seating, and loyalty rewards</li>
            <li>Friendly staff and a clean, safe environment</li>
            <li>Locally rooted, globally inspired</li>
        </ul>
        <p>
            We’re proud to be part of the community, hosting not only daily movie screenings but also private events,
            premieres, and special screenings tailored to our audience.
        </p>
        <p>
            Thank you for choosing <strong>CineLux</strong> — where every seat is the best seat in the house.
        </p>
    </div>
</asp:Content>

