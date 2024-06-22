import { NextApiRequest, NextApiResponse } from "next";
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === "POST") {
    const { name, email } = req.body;
    res
      .status(200)
      .json({ message: `Recebemos seu formulário, ${name} (${email})!` });
  } else {
    res.status(405).json({ message: "Método não permitido" });
  }
}
