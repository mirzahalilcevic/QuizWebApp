package qwa.ws;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/players")
public class PlayerEndpoint {

    @OnOpen
    public void onOpen(Session session) throws IOException {
        players.add(session);
        sendUpdatedPlayerCount();
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        players.remove(session);
        sendUpdatedPlayerCount();
    }

    private void sendUpdatedPlayerCount() throws RuntimeException {
        players.forEach(player -> {
            try {
                player.getBasicRemote().sendText(Integer.toString(players.size()));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }

    private static Set<Session> players = ConcurrentHashMap.newKeySet();
}
