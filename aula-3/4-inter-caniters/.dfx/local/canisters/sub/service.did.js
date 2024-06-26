export const idlFactory = ({ IDL }) => {
  const Counter = IDL.Record({ 'topic' : IDL.Text, 'value' : IDL.Nat });
  return IDL.Service({
    'getCount' : IDL.Func([], [IDL.Nat], ['query']),
    'init' : IDL.Func([IDL.Text], [], ['oneway']),
    'updateCount' : IDL.Func([Counter], [], ['oneway']),
  });
};
export const init = ({ IDL }) => { return []; };
