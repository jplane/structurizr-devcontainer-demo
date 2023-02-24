workspace {

    model {

        user = person "An Important User"

        system = softwareSystem "The Big System" {
            
            moduleFront = container "Frontend Module" {
                component1 = component "RDP VM"
                component2 = component "SSH VM"
            }

            moduleBack = container "Backend Module" {
                component3 = component "API endpoint"
            }

            moduleStorage = container "Storage Module" {
                component4 = component "Blob store"
            }

            moduleMessaging = container "Messaging Module" {
                component5 = component "Message Queue"
            }
        }

        user -> component1 "Uses via RDP"
        user -> component2 "Uses via SSH"
        component1 -> component3 "issues REST API requests to"
        component2 -> component3 "issues REST API requests to"
        component3 -> component4 "reads/writes data"
        component1 -> component5 "Enqueues messages to"
        component2 -> component5 "Enqueues messages to"

        azure = deploymentEnvironment "Azure Gov" {

            deploymentNode "VM components" {
                technology "Data Science VMs"
                containerInstance moduleFront
                tags "dsvm"
            }

            deploymentNode "REST APIs" {
                technology "Azure Functions"
                containerInstance moduleBack
                tags "function"
            }

            deploymentNode "Azure Storage (blob)" {
                technology "Storage Queues"
                containerInstance moduleStorage
                tags "blob"
            }

            deploymentNode "Azure Storage (queue)" {
                technology "Storage Queues"
                containerInstance moduleMessaging
                tags "queue"
            }

            deploymentNode "Azure Infrastructure" {
                infrastructureNode "ai" {
                    technology "Application Insights"
                    tags "ai"
                }

                infrastructureNode "kv" {
                    technology "Key Vault"
                    tags "kv"
                }
            }
        }
    }

    views {
        
        systemContext system "so" {
            include *
            title "System overview"
        }

        container system "sm" {
            include *
            title "System Modules"
        }

        component moduleFront "modF" {
            include *
            title "ModuleFront components"
        }

        component moduleBack "modB" {
            include *
            title "ModuleBack components"
        }

        component moduleStorage "modS" {
            include *
            title "ModuleStorage components"
        }

        component moduleMessaging "modM" {
            include *
            title "ModuleMessaging components"
        }

        deployment * azure {
            include *
            title "Azure Gov deployment"
        }

        terminology {
            person "User"
            softwareSystem "System"
            container "Module"
            component "Component"
            deploymentNode "Resource"
            infrastructureNode "Resource"
        }

        styles {

            element "Element" {
                background #4456DA
            }
            element "Person" {
                shape Person
                background #CC6843
            }
            element "dsvm" {
                icon "./icons/compute/10021-icon-service-Virtual-Machine.png"
            }
            element "blob" {
                icon "./icons/general/10780-icon-service-Blob-Block.png"
            }
            element "queue" {
                icon "./icons/general/10840-icon-service-Storage-Queue.png"
            }
            element "function" {
                icon "./icons/compute/10029-icon-service-Function-Apps.png"
            }
            element "ai" {
                icon "./icons/monitor/00012-icon-service-Application-Insights.png"
                background #808080
                shape RoundedBox
                height 200
                width 250
            }
            element "kv" {
                icon "./icons/security/10245-icon-service-Key-Vaults.png"
                background #808080
                shape RoundedBox
                height 200
                width 250
            }
        }
    }    
}