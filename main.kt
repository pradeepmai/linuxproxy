package com.example.myapplication

import java.io.InputStream
import java.io.OutputStream
import java.net.Socket
import kotlin.concurrent.thread

fun handleClient(clientSocket: Socket) {
    val request = clientSocket.getInputStream().bufferedReader().readLine()
    val firstLine = request.substringBefore("\r\n")
    val method = firstLine.split(" ")[0]
    println("Request method: $method")
    println("Request line: $firstLine")
    if (method == "CONNECT") {
        // Extract the requested host and port
        val hostPort = firstLine.split(" ")[1]
        val (host, port) = hostPort.split(":")
        // Create a connection to the requested server
        val serverSocket = Socket(host, port.toInt())
        thread { forwardData(clientSocket.getInputStream(), serverSocket.getOutputStream()) }
        thread { forwardData(serverSocket.getInputStream(), clientSocket.getOutputStream()) }
    } else {
        println("Received request: $request")
    }
}

fun forwardData(sourceStream: InputStream, destinationStream: OutputStream) {
    val buffer = ByteArray(8192)
    var bytesRead: Int
    while (sourceStream.read(buffer).also { bytesRead = it } != -1) {
        destinationStream.write(buffer, 0, bytesRead)
    }
}

fun startProxyServer(port: Int) {

    while (true) {
        println("Proxy server connected to port $port")
        val clientSocket = Socket("127.0.0.1", port)
        val clientAddress = clientSocket.remoteSocketAddress
        println("Received connection from $clientAddress")
        thread { handleClient(clientSocket) }
    }
}

fun main() {
    var port = 30000
    startProxyServer(port)
}
