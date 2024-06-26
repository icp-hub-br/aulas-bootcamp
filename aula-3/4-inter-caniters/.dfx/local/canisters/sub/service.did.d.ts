import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Counter { 'topic' : string, 'value' : bigint }
export interface _SERVICE {
  'getCount' : ActorMethod<[], bigint>,
  'init' : ActorMethod<[string], undefined>,
  'updateCount' : ActorMethod<[Counter], undefined>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
