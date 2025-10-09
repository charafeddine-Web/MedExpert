<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.medexpert.model.Utilisateur" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Roboto', Arial, sans-serif; }</style>
</head>
<body class="min-h-screen bg-gradient-to-br from-blue-700 via-sky-300 to-white flex flex-col">
<%
    HttpSession sessiontest = request.getSession(false);
    Utilisateur user = (Utilisateur) (sessiontest != null ? sessiontest.getAttribute("user") : null);
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
%>
<nav class="w-full bg-white shadow flex items-center justify-between px-8 py-4">
    <div class="text-xl font-bold text-blue-700 tracking-wide">MedExpert</div>
    <div class="flex items-center gap-4">
        <span class="text-gray-700 font-medium">Bienvenue, <%= user.getPrenom() %> <%= user.getNom() %></span>
        <span class="px-3 py-1 rounded bg-blue-100 text-blue-700 text-xs font-semibold"><%= user.getRole() %></span>
        <form action="<%=request.getContextPath()%>/logout" method="post" class="inline">
            <button type="submit" class="ml-4 px-4 py-2 rounded bg-red-500 text-white font-bold hover:bg-red-600 transition">Déconnexion</button>
        </form>
    </div>
</nav>
<main class="flex-1 flex flex-col items-center justify-center p-8">
    <div class="bg-white rounded-2xl shadow-xl p-8 w-full max-w-2xl flex flex-col items-center">
        <h1 class="text-3xl font-bold text-blue-700 mb-4">Tableau de bord</h1>
        <p class="text-gray-700 text-lg mb-6">Bienvenue sur votre espace personnel, <span class="font-semibold"><%= user.getPrenom() %> <%= user.getNom() %></span> !</p>
        <div class="w-full grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="bg-blue-50 rounded-xl p-6 flex flex-col items-center shadow">
                <span class="text-5xl text-blue-400 mb-2">👤</span>
                <span class="text-gray-700 font-semibold">Nom :</span>
                <span class="text-blue-700 mb-2"><%= user.getNom() %></span>
                <span class="text-gray-700 font-semibold">Prénom :</span>
                <span class="text-blue-700 mb-2"><%= user.getPrenom() %></span>
                <span class="text-gray-700 font-semibold">Email :</span>
                <span class="text-blue-700 mb-2"><%= user.getEmail() %></span>
                <span class="text-gray-700 font-semibold">Rôle :</span>
                <span class="text-blue-700 mb-2"><%= user.getRole() %></span>
            </div>
            <div class="bg-blue-50 rounded-xl p-6 flex flex-col items-center shadow">
                <span class="text-5xl text-blue-400 mb-2">⚙️</span>
                <span class="text-gray-700 font-semibold mb-2">Actions rapides</span>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-blue-600 text-white font-bold hover:bg-blue-700 transition">Voir mon profil</a>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-sky-500 text-white font-bold hover:bg-sky-600 transition">Modifier mes informations</a>
                <a href="#" class="w-full text-center py-2 my-1 rounded bg-green-500 text-white font-bold hover:bg-green-600 transition">Consulter mes dossiers</a>
            </div>
        </div>
    </div>
</main>
<footer class="w-full text-center py-4 text-gray-400 text-sm mt-8">
    © <%= java.time.Year.now() %> MedExpert. Tous droits réservés.
</footer>
</body>
</html>
