package qwa.messages;

public class Ack {

    public Ack(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    private final String type = "ack";

    private boolean success;
    private String message;
}
