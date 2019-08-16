package qwa.messages;

public class Ack {

    public Ack(boolean success) {
        this.success = success;
    }

    private final String type = "ack";

    private boolean success;
}
