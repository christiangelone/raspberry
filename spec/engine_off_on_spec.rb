require 'spec_helper'
require 'require_all'

require_all 'lib'

describe Engine do

  context 'StateOffOn being the actual state' do

    init_state = StateOffOn.new
    engine = Engine.new(init_state)
    p engine

    describe 'changes to StateOffOff' do

      it 'should notify> Cerradura Bloqueada,Puerta Cerrada' do
        off_off = StateOffOff.new
        response = engine.change_to(off_off)
        expected_response = 'Cerradura Bloqueada,Puerta Cerrada'
        expect(response.message).to eq expected_response
      end
    end

    describe 'changes to StateOffOn' do

      it 'should notify> Cerradura Bloqueada,Puerta Abierta |or| Cerradura Bloqueada,Puerta Violada' do
        off_on = StateOffOn.new
        response = engine.change_to(off_on)
        expected_response1 = 'Cerradura Bloqueada,Puerta Violada'
        expected_response2 = 'Cerradura Bloqueada,Puerta Abierta'
        p response.message
        expect(response.message).to eq(expected_response1).or eq(expected_response2)
      end
    end

    describe 'changes to StateOnOff' do

      it 'should notify> Cerradura Activada,Puerta Cerrada' do
        on_off = StateOnOff.new
        response = engine.change_to(on_off)
        expected_response = 'Cerradura Activada,Puerta Cerrada'
        expect(response.message).to eq expected_response
      end
    end

    describe 'changes to StateOnOn' do

      it 'should notify> Cerradura Activada,Puerta Abierta' do
        on_on = StateOnOn.new
        response = engine.change_to(on_on)
        expected_response = 'Cerradura Activada,Puerta Abierta'
        expect(response.message).to eq expected_response
      end
    end
  end
end
