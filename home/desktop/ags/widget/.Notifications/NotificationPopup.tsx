import { timeout } from "astal";
import { App, Astal, hook, Gdk } from "astal/gtk4";
import AstalNotifd from "gi://AstalNotifd";
import Notification from ".";

export default function NotificationPopup(monitor: number) {
    const notifd = AstalNotifd.get_default();

    return (
        <window
            application={App}
            name={"notification"}
            namespace={"notification"}
            cssClasses={["notification"]}
            monitor={monitor}
            anchor={TOP | LEFT}
            setup={(self) => {
                const notificationQueue: number[] = [];
                let isProcessing = false;

                hook(self, notifd, "notified", (_, id: number) => {
                    if (
                        notifd.dont_disturb &&
                        notifd.get_notification(id).urgency != AstalNotifd.Urgency.CRITICAL
                    ) {
                        return;
                    }
                    notificationQueue.push(id);
                    processQueue();
                });

                hook(self, notifd, "resolved", (_, __) => {
                    self.visible = false;
                    isProcessing = false;
                    timeout(300, () => {
                        processQueue();
                    });
                });

                function processQueue() {
                    if (isProcessing || notificationQueue.length === 0) return;
                    isProcessing = true;
                    const id = notificationQueue.shift();

                    self.set_child(
                        <box vertical>
                            <box/>
                        </box>,
                    );
                    self.visible = true;

                    timeout(5000, () => {
                        self.visible = false;
                        isProcessing = false;
                        self.set_child(null);
                        timeout(300, () => {
                            processQueue();
                        });
                    });
                }
            }}
        />
    );
}
