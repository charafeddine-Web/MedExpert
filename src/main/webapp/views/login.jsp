<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - MedExpert</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Roboto', Arial, sans-serif; }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-gray-50">
<div class="w-full max-w-md bg-white rounded-2xl shadow p-8 flex flex-col items-center border border-slate-200">
    <h2 class="text-2xl font-bold text-slate-900 mb-6 tracking-tight">Connexion à MedExpert</h2>
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="w-full mb-4 px-4 py-3 rounded bg-red-50 border border-red-200 text-red-700 text-center text-base"><%= error %></div>
    <% } %>
    <form action="<%=request.getContextPath()%>/login" method="post" autocomplete="off" class="w-full flex flex-col gap-4">
        <div class="flex flex-col gap-1">
            <label for="email" class="text-gray-700 font-medium">Adresse e-mail</label>
            <input type="email" id="email" name="email" placeholder="Entrez votre e-mail" required autofocus
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <div class="flex flex-col gap-1">
            <label for="password" class="text-gray-700 font-medium">Mot de passe</label>
            <input type="password" id="password" name="password" placeholder="Entrez votre mot de passe" required
                   class="px-4 py-2 rounded border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-400 bg-gray-50" />
        </div>
        <button type="submit" class="w-full py-2 mt-2 rounded bg-sky-600 hover:bg-sky-700 text-white font-semibold text-lg shadow">Se connecter</button>
    </form>
    <div class="mt-6 text-gray-500 text-sm text-center">
        © <%= java.time.Year.now() %> MedExpert. Tous droits réservés.
    </div>
</div>
</body>
</html>
