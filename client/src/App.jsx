import { Route, Router } from "@solidjs/router";
import { HomePage, AuctionPage } from "./pages";

function App() {
  return (
    <div class="h-screen bg-background text-text p-8">
      <Router>
        <Route path="/" component={HomePage} />
        <Route path="/auction" component={AuctionPage} />
      </Router>
    </div>
  );
}

export default App;
