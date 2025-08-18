<%@ Page Title="Cinelux Locations" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cinemas.aspx.cs" Inherits="Cinema_2025.Cinemas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #map {
            width: 100%;
            height: 500px;
            margin-top: 20px;
            border: 2px solid #ccc;
        }
        .location-controls {
            margin: 15px 0;
        }
        select, button {
            padding: 8px;
            margin-right: 5px;
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Cinelux Cinema Finder</h1>
    <p>Find your nearest Cinelux cinema in Cape Town.</p>

    <div class="location-controls">
        <button id="btnLocation" type="button" onclick="getUserLocation()" disabled>Use My Location</button>

        <select id="cinemaSelect" onchange="goToCinema()">
            <option value="">-- Select a Cinema --</option>
            <option value="-33.9249,18.4241">Cinelux City Centre</option>
            <option value="-34.0363,18.4684">Cinelux Claremont</option>
            <option value="-33.8301,18.6471">Cinelux Blouberg</option>
            <option value="-34.1422,18.3500">Cinelux Noordhoek</option>
        </select>
    </div>

    <div id="map"></div>

    <script>
        let map, userMarker;

        const cinemas = [
            { name: "Cinelux City Centre", lat: -33.9249, lng: 18.4241 },
            { name: "Cinelux Claremont", lat: -34.0363, lng: 18.4684 },
            { name: "Cinelux Blouberg", lat: -33.8301, lng: 18.6471 },
            { name: "Cinelux Noordhoek", lat: -34.1422, lng: 18.3500 }
        ];

        function initMap() {
            map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: -33.9249, lng: 18.4241 },
                zoom: 11
            });

            cinemas.forEach(cinema => {
                new google.maps.Marker({
                    position: { lat: cinema.lat, lng: cinema.lng },
                    map,
                    title: cinema.name
                });
            });

            // Enable the location button now that the map is ready
            document.getElementById("btnLocation").disabled = false;
        }

        function getUserLocation() {
            if (!map) {
                alert("Map is still loading, please wait a moment.");
                return;
            }

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                    const userPos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    if (userMarker) userMarker.setMap(null);
                    userMarker = new google.maps.Marker({
                        position: userPos,
                        map,
                        title: "You are here",
                        icon: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
                    });

                    map.setCenter(userPos);
                    map.setZoom(12);

                    goToNearestCinema(userPos);
                }, () => alert("Unable to get your location."));
            } else {
                alert("Geolocation not supported in your browser.");
            }
        }

        function goToNearestCinema(userPos) {
            let nearest = null;
            let minDist = Number.MAX_VALUE;

            cinemas.forEach(cinema => {
                const dist = getDistance(userPos.lat, userPos.lng, cinema.lat, cinema.lng);
                if (dist < minDist) {
                    minDist = dist;
                    nearest = cinema;
                }
            });

            if (nearest) {
                map.setCenter({ lat: nearest.lat, lng: nearest.lng });
                map.setZoom(14);
            }
        }

        function getDistance(lat1, lon1, lat2, lon2) {
            const R = 6371;
            const dLat = (lat2 - lat1) * Math.PI / 180;
            const dLon = (lon2 - lon1) * Math.PI / 180;
            const a = Math.sin(dLat / 2) ** 2 +
                Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                Math.sin(dLon / 2) ** 2;
            return R * (2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)));
        }

        function goToCinema() {
            const val = document.getElementById("cinemaSelect").value;
            if (val) {
                const [lat, lng] = val.split(",").map(Number);
                map.setCenter({ lat, lng });
                map.setZoom(14);
            }
        }
    </script>

    <!-- Google Maps API -->
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCPgKCMv2Qp1hV9XpL8NZeLwmIN6weF0QQ&callback=initMap">
    </script>
</asp:Content>


