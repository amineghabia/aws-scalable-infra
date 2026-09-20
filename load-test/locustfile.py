from locust import HttpUser, task, between
import random

class InferenceUser(HttpUser):
    wait_time = between(0.1, 0.5)

    @task(1)
    def health_check(self):
        self.client.get("/health")

    @task(9)
    def predict(self):
        # Random valid LunarLander observation (8 floats)
        obs = [random.uniform(-1, 1) for _ in range(8)]
        self.client.post("/predict", json={"obs": obs})
