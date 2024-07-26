import { createContext, useContext, createSignal } from 'solid-js';

export const StateContext = createContext();

export const StateContextProvider = (props) => {

  const [walletData, setWalletData] = createSignal("");

  const connectToMetamask = async () => {
    if (window.ethereum) {
      window.ethereum
        .request({ method: "eth_requestAccounts" })
        .then((res) =>
          setWalletData(res[0])
        );
    } else {
      alert("Install Metamask Extension");
    }
  }

  return (
    <StateContext.Provider
      value={{
        connectToMetamask,
        walletData
      }}
    >
      {props.children}
    </StateContext.Provider>
  )
}


export const useStateContext = () => {
  return useContext(StateContext);
}
