<%@ Page Title="Delete Movie" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Delete.aspx.cs" Inherits="Cinema_2025.Delete" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
        }

        table {
            width: 90%;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        td {
            padding: 10px;
            color: #333333;
            font-size: 16px;
        }

        .styled-input {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 150px;
            margin-right: 10px;
        }

        .delete-button {
            background-color: #d9534f;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .delete-button:hover {
            background-color: #c9302c;
        }

        .message-label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
        }

        .gridview-style {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        .gridview-style th {
            background-color: #333;
            color: #fff;
            padding: 10px;
        }

        .gridview-style td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        /* Modal Styles */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1000; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgba(0,0,0,0.5); 
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto; 
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            text-align: center;
            box-shadow: 0 0 15px red;
        }

        .modal-buttons {
            margin-top: 20px;
        }

        .modal-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            margin: 0 10px;
            cursor: pointer;
        }

        .confirm-button {
            background-color: red;
            color: white;
        }

        .confirm-button:hover {
            background-color: darkred;
        }

        .cancel-button {
            background-color: #ccc;
        }

        .cancel-button:hover {
            background-color: #aaa;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td style="font-weight: bold; font-size: 20px; text-align: center;">
                DELETE MOVIE
            </td>
        </tr>
        <tr>
            <td style="text-align: center;">
                ENTER MOVIE CODE TO DELETE MOVIE<br />
                <asp:TextBox ID="TextBox1" runat="server" CssClass="styled-input" />
                <asp:Button ID="DeleteBtn" runat="server" Text="Delete Movie" CssClass="delete-button" OnClientClick="showModal(); return false;" />
                <asp:Label ID="MessageLabel" runat="server" CssClass="message-label" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1"
                              runat="server"
                              AutoGenerateColumns="False"
                              DataKeyNames="MovieID"
                              DataSourceID="SqlDataSource1"
                              CssClass="gridview-style">
                    <Columns>
                        <asp:BoundField DataField="MovieID" HeaderText="MovieID" ReadOnly="True" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Genre" HeaderText="Genre" />
                        <asp:BoundField DataField="ReleaseDate" HeaderText="ReleaseDate" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Language" HeaderText="Language" />
                        <asp:BoundField DataField="Country" HeaderText="Country" />
                        <asp:BoundField DataField="Rating" HeaderText="Rating" />
                        <asp:BoundField DataField="Format" HeaderText="Format" />
                        <asp:BoundField DataField="MovieCode" HeaderText="MovieCode" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="DirectorName" HeaderText="DirectorName" />
                    </Columns>
                </asp:GridView>

                <asp:SqlDataSource ID="SqlDataSource1"
                                   runat="server"
                                   ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                                   SelectCommand="SELECT [MovieID], [Title], [Genre], [ReleaseDate], [Language], [Country], [Rating], [Format], [MovieCode], [Price], [DirectorName] FROM [Movies]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

    <!-- Modal -->
    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <p>Are you sure you want to delete this movie?</p>
            <div class="modal-buttons">
                <asp:Button ID="ConfirmDeleteBtn" runat="server" Text="Yes" CssClass="confirm-button" OnClick="DeleteBtn_Click" />
                <button type="button" class="cancel-button" onclick="closeModal();">Cancel</button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showModal() {
            document.getElementById('confirmModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('confirmModal').style.display = 'none';
        }
    </script>
</asp:Content>

