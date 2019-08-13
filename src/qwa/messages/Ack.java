package qwa.messages;

public class Ack {

    public static final String type = "ack";

    public Ack(boolean success) {
        this.success = success;
    }

    private boolean success;
}
