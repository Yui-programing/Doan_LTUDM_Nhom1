package com.example.client;

import javafx.application.Application;
import javafx.stage.Stage;

public class ClientApplication extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        primaryStage.setTitle("Song Search Application - Client");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
