# Use the official .NET 7 SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

# Set the working directory
WORKDIR /src

# Clone the GitHub repository
RUN git clone https://github.com/StyxUT/PowerConsumptionOptimizer.git

# Copy the entire PCO directory into the working directory
# COPY PCO/ ./PCO/

# Change the working directory to PCO
WORKDIR /src/PowerConsumptionOptimizer

# Restore the packages
RUN dotnet restore ./PCO.sln

# Build the application in Release mode
RUN dotnet build -c Release -o /app/build

# Publish the main project only (replace the project path with the actual path to your main project)
RUN dotnet publish -c Release -o /app/publish PowerConsumptionOptimizer/PowerConsumptionOptimizer.csproj

# Use the official .NET 7 runtime image for the final stage
FROM mcr.microsoft.com/dotnet/runtime:7.0

# Set the working directory
WORKDIR /app

# Copy the published files from the build stage into the working directory
# Server
FROM mcr.microsoft.com/dotnet/aspnet:7.0.4-alpine3.17 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./

# Set the entrypoint for the application
ENTRYPOINT ["dotnet", "PowerConsumptionOptimizer.dll"]

