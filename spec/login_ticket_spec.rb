require "spec_helper"

include RubyCAS::Server::Core::Tickets

describe RubyCAS::Server::Core::Tickets do
  let(:ticket) { 'Example Ticket' }
  let(:client_hostname) { 'Example client' }

  describe LoginTicket do
    before do
      @login_ticket = LoginTicket.new(
        ticket: ticket,
        consumed: Time.at(rand * Time.now.to_i),
        client_hostname: client_hostname,
      )
    end

    it "responds to properties" do
      expect(@login_ticket).to respond_to(:ticket)
      expect(@login_ticket).to respond_to(:consumed)
      expect(@login_ticket).to respond_to(:client_hostname)
      expect(@login_ticket).to respond_to(:consume!)
    end

    it "stores ticket correctly" do
      expect(@login_ticket.ticket).to eq ticket
    end

    it "stores client_hostname correctly" do
      expect(@login_ticket.client_hostname).to eq client_hostname
    end
  end

  describe ProxyGrantingTicket do
    let(:iou) { "Example IOU" }

    before do
      @proxy_granting_ticket = ProxyGrantingTicket.new(
        ticket: ticket,
        client_hostname: client_hostname,
        iou: iou
      )
    end

    it "responds to properties" do
      expect(@proxy_granting_ticket).to respond_to(:ticket)
      expect(@proxy_granting_ticket).to respond_to(:client_hostname)
      expect(@proxy_granting_ticket).to respond_to(:iou)
    end

    it "stores ticket correctly" do
      expect(@proxy_granting_ticket.ticket).to eq ticket
    end

    it "stores client_hostname correctly" do
      expect(@proxy_granting_ticket.client_hostname).to eq client_hostname
    end

    it "stores iou correctly" do
      skip#expect(@proxy_granting_ticket.iou).to eq iou
    end
  end


  describe TicketGrantingTicket do
    let(:username) { 'username' }

    before do
      @ticket_granting_ticket = TicketGrantingTicket.new(
        ticket: ticket,
        client_hostname: client_hostname,
        username: username,
      )
    end

    it "responds to properties" do
      expect(@ticket_granting_ticket).to respond_to(:ticket)
      expect(@ticket_granting_ticket).to respond_to(:client_hostname)
      expect(@ticket_granting_ticket).to respond_to(:username)
      expect(@ticket_granting_ticket).to respond_to(:remember_me)
    end

    it "stores ticket correctly" do
      expect(@ticket_granting_ticket.ticket).to eq ticket
    end

    it "stores client_hostname correctly" do
      expect(@ticket_granting_ticket.client_hostname).to eq client_hostname
    end

    it "stores username correctly" do
      expect(@ticket_granting_ticket.username).to eq username
    end

    it "remember_me gets the default value false" do
      expect(@ticket_granting_ticket.remember_me).to eq false
    end
  end


  describe ServiceTicket do
    let(:service_ticket) { 'Example Service Ticket' }
    let(:service) { 'Example Service' }
    let(:username) { 'username' }

    before do
      @ticket_granting_ticket = TicketGrantingTicket.new(
        ticket: ticket,
        client_hostname: client_hostname,
        username: username,
      )

      @service_ticket = ServiceTicket.new(
        ticket: ticket,
        service: service,
        username: username,
        client_hostname: client_hostname,
        ticket_granting_ticket: @ticket_granting_ticket
      )
    end

    subject {@service_ticket}
    its(:ticket_granting_ticket) { should eq(@ticket_granting_ticket) }

    it "responds to properties" do
      expect(@service_ticket).to respond_to(:ticket)
      expect(@service_ticket).to respond_to(:service)
      expect(@service_ticket).to respond_to(:consumed)
      expect(@service_ticket).to respond_to(:ticket_granting_ticket)
    end

    it "stores ticket correctly" do
      expect(@service_ticket.ticket).to eq ticket
    end

    it "stores client_hostname correctly" do
      expect(@service_ticket.client_hostname).to eq client_hostname
    end

    it "stores username correctly" do
      expect(@service_ticket.username).to eq username
    end

    it "stores service correctly" do
      expect(@service_ticket.service).to eq service
    end

    it "stores ticket granting ticket correctly" do
      expect(@service_ticket.ticket_granting_ticket).to eq @ticket_granting_ticket
    end
  end


end
