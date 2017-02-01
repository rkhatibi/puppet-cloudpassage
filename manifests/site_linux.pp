node default {
        class {'cloudpassage':
                agent_key => $halo_agent_key,
                tag => 'hlee'
        }
}