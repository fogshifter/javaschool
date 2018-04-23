package com.tmobile.entity;

import javax.persistence.*;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import java.util.List;
import java.util.ArrayList;
import java.util.Objects;


@Entity
@Table(name = "tariff")
public class Tariff {
	
	private int id;
	private String name;
	private String description;
	private int price;
	private boolean defaultTariff = false;

	private List<TariffOptions> defaultOptions = new ArrayList<>();

    @OneToMany(mappedBy = "tariff", cascade = CascadeType.ALL, orphanRemoval = true)
	public List<TariffOptions> getDefaultOptions() {
	    return defaultOptions;
    }

    public void setDefaultOptions(List<TariffOptions> tariffOptions) {
        this.defaultOptions = tariffOptions;
    }

    public void addCompatibleOption(Option option) {
	    TariffOptions tariffOption = new TariffOptions(this, option);

	    defaultOptions.add(tariffOption);
	    option.getCompatibleTariffs().add(tariffOption);
    }

    public void removeCompatibleOption(Option option) {
        TariffOptions tariffOptions = new TariffOptions(this, option);
        option.getCompatibleTariffs().remove(tariffOptions);
        defaultOptions.remove(tariffOptions);
        tariffOptions.setOption(null);
        tariffOptions.setTariff(null);
    }

	@Id
	@Column(name = "id")
	@GeneratedValue(generator = "increment")
	@GenericGenerator(name = "increment", strategy = "increment")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Column(name = "name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description")
    @Type(type = "text")
    public String getDescription() {
        return description;
    }

    public void setDescription(String desc) {
        this.description = desc;
    }

	@Column(name = "price")
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}

	@Column(name = "default_flag")
	public boolean isDefaultTariff() {
        return defaultTariff;
    }

    public void setDefaultTariff(boolean flag) {
        this.defaultTariff = flag;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Tariff)) return false;
        Tariff tariff = (Tariff) o;
        return id == tariff.id &&
                price == tariff.price &&
                Objects.equals(name, tariff.name);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, name, price, defaultTariff);
    }
}