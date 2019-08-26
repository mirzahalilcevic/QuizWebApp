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
        spectators.add(session);
        session.getBasicRemote().sendText(Integer.toString(players.size()));
    }

    @OnMessage
    public void onMessage(Session session, String message) throws IOException {
        if (message.equals("start")) {
            spectators.remove(session);
            players.add(session);
        } else if (message.equals("stop")) {
            players.remove(session);
            spectators.add(session);
        }
        sendPlayerCount();
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        if (players.remove(session))
            sendPlayerCount();
        else
            spectators.remove(session);
    }

    private void sendPlayerCount() throws RuntimeException {
        players.forEach(player -> {
            try {
                player.getBasicRemote().sendText(Integer.toString(players.size()));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
        spectators.forEach(spectator -> {
            try {
                spectator.getBasicRemote().sendText(Integer.toString(players.size()));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }

    private static Set<Session> players = ConcurrentHashMap.newKeySet();
    private static Set<Session> spectators = ConcurrentHashMap.newKeySet();
}
