FROM mcr.microsoft.com/dotnet/core/aspnetcore:3.1
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS=https://*:5000

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /src
COPY ["appsolutions.csproj","/"]
RUN dotnet restore "./appsolutions.csproj"
COPY  . .
WORKDIR /src/.
RUN dotnet build "appsolutions.csproj" -c Release -o /app/build

FROM build AS publishgit staut
RUN dotnet publish "appsolutions.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet","appsoultions.dll" ]